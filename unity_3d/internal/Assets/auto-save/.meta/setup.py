import os
import git

default_version='0.1.0'

types = [
    'KOC',
    'AI',
    'AI (Permissive)',
    'Third Party',
    'Unity'
]
license_options = [
    'AGPL',
    'AGPL',
    'MIT',
    'UCL',
    'ASEULA'
    ]

token_files = [
    'README.md', 
    'package.json',
    'CHANGELOG.md'
    ]

class TokenReplacementSet:
    def __init__(self, message):
        self.value = ''
        self.message = message

tokens = {
    'package' : TokenReplacementSet('Enter the name of the package'),
    'display' : TokenReplacementSet('Enter the display name of the package'),
    'version' : TokenReplacementSet('Enter the intitial ersion of the package'),
    'description' : TokenReplacementSet('Enter a description of the package'),
    'license' : TokenReplacementSet('Enter the license of the package'),
    'author' : TokenReplacementSet('Enter the author of the package'),
    }
    

def remove_file(path, include_meta=True):
    meta = '{0}.meta'.format(path)
    os.remove(path)
    if include_meta and os.path.isfile(meta):
        os.remove(meta)

def rename_file(old, new, include_meta=True):
    meta_old = '{0}.meta'.format(old)
    meta_new = '{0}.meta'.format(new)
    os.rename(old, new)
    if include_meta and os.path.isfile(meta_old):
        os.rename(meta_old, meta_new)

def no_validation(parameter):
    return True

def do_parameter(message, validation):
    parameter = ''
    while True:
        parameter = raw_input("{0}:  ".format(message))

        if validation(parameter):
            break
    
    return parameter

def do_selection(options, message):
    while True:
        for index, option in enumerate(options):
            print('[{0}]: {1}'.format(index, option))
        
        selection = raw_input('{0}:  '.format(message))

        try:
            selection_int = int(selection)
            return selection_int
        except Exception as e:
            print('Try again...')

def process_version_file(version):
    with os.open('./version', 'w') as fs:
        fs.write(version)

def process_token_replacements(tokens):    
    print('Replacing tokens...')

    for token_file in token_files:
        with os.open(token_file, 'w') as fs:
            lines = fs.read()

            for line in lines:
                for token_key in tokens.keys():
                    old = f'!!{token_key}!!'
                    token = tokens[token_key]
                    new = token.value

                    if new == '':
                        new = do_parameter(token.message, no_validation)
                    else:
                        print(f'{token.message}:  {token.value}')

                    line = line.replace(old, new)

            fs.write(lines)
    print('Token replacement completed.')

def process_license(license_index):
    license_type = license_options[license_index]
    print('Updating license to use {0}'.format(license_type))

    for lt in license_types:
        license_file = './LICENSE_{0}.md'.format(lt)
        license_file_meta = './{0}.meta'.format(license_file)

        if lt == license_type:
            target_file = '../LICENSE.md'
            rename_file(license_file, target_file, True)
        else:
            remove_file(license_file)

def process_workspace(token_package):
    echo 'Renaming workspace...'
    workspace_file = 'workspace.code-workspace'
    target_file = workspace_file.replace('workspace', token_package.value)
    
    rename_file(workspace_file, target_file, True)

def process_repository(package):
    print('Initializing repository...')        

    remote_url = f'https://github.com/AppalachiaInteractive/{package}.git'
    repo = git.Repo.init('.')                         # git init
    repo.index.add('.')                               # git add .
    print('Creating main branch...')
    main = repo.create_head('main')                   # git branch -M main
    repo.active_branch = main

    print('Configuring remote...')
    origin = repo.create_remote('origin', remote_url) # git remote add origin $remote_url
    assert origin.exists()
    assert origin == repo.remotes.origin == repo.remotes['origin']
    repo.heads.main.set_tracking_branch(origin.refs.main)

    print('Committing changes...')
    repo.index.commit('initializing organization repository')  #git commit -m "initializing organization repository"

    print('Pushing changes...')
    origin.push()                                               # git push -u origin main
    

def execute():
          
    tokens['version'].value = default_version

    directory = os.getcwd()

    is_directory_valid = do_ask(f'Is {directory} the intended directory?')

    if not is_directory_valid:
        directory = do_parameter("Enter the package directory (starting with ~/)", os.path.isdir)    
        os.chdir(directory)
    
    package_type = do_selection(types, "Select the package type")

    package_token = tokens[package_type]

    home = os.getenv("HOME")
    absolute = os.path.abspath(directory)
    package = absolute.replace(home, '').replace('\\\\','.').replace('\\','.').replace('/','.').replace('..','.')

    correct = do_ask(f"Is this the correct package?  {package}")
    
    if not correct:
        return

    parts = package.split('.')

    print(package_token.value)        

    if package_token.value == 'KOC':
        #com.appalachia.koc.audio
        if len(parts) != 4:
            raise ValueError(package_token.value)
        tokens['author'].value = 'Appalachia Interactive'
        tokens['package'].value = tail
        suffix = parts[4].replace('-', ' ').title().replace(' ', '')
        tokens['display'].value = f'Appalachia Interactive - KOC - {suffix}'
        tokens['license'].value = 'AGPL'

    elif package_token.value == 'AI':
        #com.appalachia.audio
        if len(parts) != 3:
            raise ValueError(package_token.value)
        tokens['author'].value = 'Appalachia Interactive'
        tokens['package'].value = tail
        suffix = parts[3].replace('-', ' ').title().replace(' ', '')
        tokens['display'].value = f'Appalachia Interactive - {suffix}'
        tokens['license'].value = 'AGPL'

    elif package_token.value == 'AI (Permissive)':
        #com.appalachia.audio
        if len(parts) != 3:
            raise ValueError(package_token.value)
        tokens['author'].value = 'Appalachia Interactive'
        tokens['package'].value = tail
        suffix = parts[3].replace('-', ' ').title().replace(' ', '')
        tokens['display'].value = f'Appalachia Interactive - {suffix}'
        tokens['license'].value = 'MIT'

    elif package_token.value == 'Third Party':        
        # com.appalachia.third-party.amplify.shader-editor
        if len(parts) != 5:
            raise ValueError(package_token.value)
        
        tokens['author'].value = parts[3].replace('-', ' ').title()
        tokens['package'].value = tail
        tokens['display'].value = f'{parts[3]} - {parts[4]}'.replace('-', ' ').title()
        tokens['license'].value = 'ASEULA'

    elif package_token.value == 'Unity':
        # com.appalachia.unity.cinemachine
        if len(parts) != 4:
            raise ValueError(package_token.value)
        tokens['author'].value = 'Unity Technologies'
        tokens['package'].value = tail
        tokens['display'].value = f'Unity Technologies - {parts[3]}'.replace('-', ' ').title()
        tokens['license'].value = 'UCL'

    else: 
        raise ValueError(package_token.value)


    process_version_file(default_version)

    process_token_replacements(tokens)  

    process_license(package_type)

    process_repository(package_token.value)

   

execute()