import os, shutil
import git

DRY_RUN=False

default_version='0.1.0'

package_types = [
    'Appalachia Interactive',
    'Third Party',
    'Unity Technologies',
    'Asset Store',
]

categories = [
    'General',
    'Unity Project',
    'Unity Package'
]

category_templates = [
    'com.appalachia/.templates/com.appalachia',
    'com.appalachia/.templates/com.appalachia.unity3d',
    'com.appalachia/.templates/com.appalachia.unity3d.package'
]

license_dir = 'com.appalachia/.licenses'
internal_license_options = [
    'NONE',
    'AGPL',
    'MIT'
]

unity_license_options = [
    'MIT',
    'UCL',
    'ASEULA'
]

external_license_options = [
    'AGPL',
    'GPL',
    'LGPL',
    'MIT',
    'APL',
    'MPL',
    'UCL',
    'ASEULA'
]

license_notes = {
    'NONE' : 'None - This work will not be explicitly licensed, which releases no rights to the work to the public.',
    'AGPL' : 'GNU AGPLv3 - Permissions of this strongest copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license.',
    'GPL' : 'GNU GPLv3 - Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license.',
    'LGPL' : 'GNU LGPLv3 - Permissions of this copyleft license are conditioned on making available complete source code of licensed works and modifications under the same license or the GNU GPLv3.',
    'MIT' : 'MIT License - A short and simple permissive license with conditions only requiring preservation of copyright and license notices.',
    'APL' : 'Apache License 2.0 - A permissive license whose main conditions require preservation of copyright and license notices.',
    'MPL' : 'Mozilla Public License 2.0 - Permissions of this weak copyleft license are conditioned on making available source code of licensed files and modifications of those files under the same license.',
    'UCL' : 'Unity Companion License - For open-source projects created by Unity Technologies ApS.',
    'ASEULA' : 'Asset Store End User License Agreement - For assets purchased on the Unity Asset Store',
}

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
    'project' : TokenReplacementSet('Enter the name of the project'),
    'display' : TokenReplacementSet('Enter the display name of the package'),
    'version' : TokenReplacementSet('Enter the intitial ersion of the package'),
    'description' : TokenReplacementSet('Enter a description of the package'),
    'license' : TokenReplacementSet('Enter the license of the package'),
    'author' : TokenReplacementSet('Enter the author of the package'),
    }
    

def remove_file(path, include_meta=True):
    if DRY_RUN:
        return

    meta = '{0}.meta'.format(path)
    os.remove(path)
    if include_meta and os.path.isfile(meta):
        os.remove(meta)


def rename_file(old, new, include_meta=True):
    if DRY_RUN:
        return

    meta_old = '{0}.meta'.format(old)
    meta_new = '{0}.meta'.format(new)
    os.rename(old, new)
    if include_meta and os.path.isfile(meta_old):
        os.rename(meta_old, meta_new)


def no_validation(parameter):
    return True


def should_quit(parameter):
    if parameter == '':
        return False

    l = parameter.lower()

    if l == 'x' or l == 'exit' or l == 'quit':
        return True
    return False


def do_ask(message):
    parameter = ''
    while True:
        parameter = input("{0}:  ".format(message))

        if parameter == '':
            continue
        
        l = parameter.lower()
        if l == 'y' or l == '1' or l == 't':
            return True
        if l == 'n' or l == '0' or l == 'f':
            return False
       
        if should_quit(parameter):
            raise ValueError(parameter)
    
    return parameter


def do_parameter(message, validation):
    parameter = ''
    while True:
        parameter = input("{0}:  ".format(message))

        if should_quit(parameter):
            raise ValueError(parameter)

        if validation(parameter):
            break
    
    return parameter


def do_selection(options, message):
    mini, maxi = 1, len(options)
    while True:
        for index, option in enumerate(options):
            print('[{0}]: {1}'.format(index+1, option))
        
        parameter = input('{0}:  '.format(message))
        
        if should_quit(parameter):
            raise ValueError(parameter)


        try:
            parameter_int = int(parameter)
            
            assert(parameter_int >= mini and parameter_int <= maxi)
            parameter_int = parameter_int - 1
            return parameter_int            

        except Exception as e:
            print('Try again...')


def do_ask_until_confirmed(initial_value, confirmation_message, enter_message, enter_validation):
    confirmation=False
    value = initial_value
    while not confirmation:
        confirmation = do_ask(confirmation_message.format(value))
        if not confirmation:
            value = do_parameter(enter_message, enter_validation)  

    return value


def do_selection_until_confirmed(confirmation_message, confirmation_notes, selection_options, selection_message, ):
    confirmation=False
    value = do_selection(selection_options, selection_message)
    while not confirmation:
        if confirmation_notes:
            print(confirmation_notes[selection_options[value]])

        confirmation = do_ask(confirmation_message.format(selection_options[value]))
        if not confirmation:
            value = do_selection(selection_options, selection_message)

    return value


def get_directory():
    directory = os.getcwd()

    directory = do_ask_until_confirmed(directory, 'Is {0} the intended directory?', "Enter the directory (starting with ~/)", os.path.isdir)
      
    os.chdir(directory)
    return directory


def get_license(license_options):    
    
    license_index  = do_selection_until_confirmed('Is {0} the intended license?', license_notes, license_options, 'Enter the license')
      
    return license_index


def get_package(directory):
    home = os.getenv("HOME")
    absolute = os.path.abspath(directory)
    package = (absolute.replace(home, '')
        .replace('Assets','').replace('internal','').replace('experimental','')
        .replace('\\\\','.').replace('\\\\','.').replace('\\','.')
        .replace('/','.').replace('..','.').replace('..','.').replace('..','.')
        .strip('.'))

    package = do_ask_until_confirmed(package, 'Is this the correct package?  {0}', 'Enter the package name', no_validation)

    if len(package) < 8:
        raise ValueError(package)
    
    return package


# def process_version_file(version):
#    if DRY_RUN:
#        print(version)
#        return
#    
#    with open('./version', mode= 'w') as fs:
#        fs.write(version)


def process_token_replacements():    
    print('Replacing tokens...')

    for token_file in token_files:
        if DRY_RUN:        
            print(token_file)
            if not os.path.isfile(token_file):
                print(f'Missing {token_file}')
                continue                
            
        
        lines = []
        with open(token_file, mode='r') as fs:
            for line in fs:
                for token_key in tokens.keys():
                    old = f'!!{token_key}!!'
                    token = tokens[token_key]
                    new = token.value
                    line = line.replace(old, new)

                lines.append(line)

            if DRY_RUN:
                print(lines)
                continue

        with open(token_file, mode='w') as fs:
            fs.write(''.join(lines))
            
    print('Token replacement completed.')


def process_license(is_internal):
    license_type = tokens['license'].value

    if license_type == 'NONE':
        return
        
    print('Updating license to use {0}'.format(license_type))

    license_file = os.path.join(
        os.getenv("HOME"),
        license_dir, 
        'internal' if is_internal else 'external', 
        'LICENSE_{0}.md'.format(license_type))


    if DRY_RUN:
        print(license_file)
        return
    
    shutil.copy(license_file, 'LICENSE.md')


def process_workspace(package):
    print('Renaming workspace...')
    workspace_file = 'workspace.code-workspace'
    target_file = workspace_file.replace('workspace', package)
    
    rename_file(workspace_file, target_file, True)


def process_repository(directory, package):
    print('Initializing repository...')        

    remote_url = f'https://github.com/AppalachiaInteractive/{package}.git'

    if DRY_RUN:
        print(remote_url)
        return
    try:
        repo = git.Repo(directory)
        assert repo.bare
    except git.InvalidGitRepositoryError:
        pass
    
    print("Creating repository...")
    repo = git.Repo.init(directory)                     # git init

    if not do_ask("Done.  Proceed?"):
        return

    print("Adding README.md to index...")
    repo.index.add('README.md')                         # git add 'README.md'
    
    if not do_ask("Done.  Proceed?"):
        return

    print('Committing changes...')
    repo.index.commit('Added Readme.MD')  #git commit -m "initializing organization repository"

    if not do_ask("Done.  Proceed?"):
        return

    print('Creating main branch...')
    main = repo.create_head('main')                      # git branch -M main

    if not do_ask("Done.  Proceed?"):
        return
        
    print('Setting main branch active...')
    if repo.active_branch != main:
        repo.active_branch.checkout()

    if not do_ask("Done.  Proceed?"):
        return

    print('Configuring remote...')
    origin = repo.create_remote('origin', remote_url) # git remote add origin $remote_url
    
    if not do_ask("Done.  Proceed?"):
        return

    if not origin.exists():
        can_create = do_ask(f'The origin at [{remote_url}] does not exist.  Can you create it?')

        if not can_create:
            return
    
    print('Confirming origin...')
    assert origin.exists()
    assert origin == repo.remotes.origin == repo.remotes['origin']
    
    if not do_ask("Done.  Proceed?"):
        return

    print('Seting main tracking branch...')
    repo.heads.main.set_tracking_branch(origin.refs.main)

    if not do_ask("Done.  Proceed?"):
        return

    print("Adding files to index...")
    repo.index.add(os.getcwd())                       # git add .
    
    if not do_ask("Done.  Proceed?"):
        return

    print('Committing changes...')
    repo.index.commit('initializing organization repository')  #git commit -m "initializing organization repository"

    if not do_ask("Done.  Proceed?"):
        return

    print('Pushing changes...')
    origin.push()                                               # git push -u origin main
    
def get_clean_part(value):    
    return value.replace('-', ' ').replace('3d','3D').title()

def package_appalachiainteractive(package, parts):    
    if len(parts) == 3:
        #com.appalachia.library
        libr = get_clean_part(parts[2])
        tokens['display'].value = f'{libr}'
    if len(parts) == 4:
        #com.appalachia.technology.library
        tech = get_clean_part(parts[2])
        libr = get_clean_part(parts[3])
        tokens['display'].value = f'{tech} {libr}'
    elif len(parts) == 5:
        #com.appalachia.project.technology.library
        proj = get_clean_part(parts[2])
        tech = get_clean_part(parts[3])
        libr = get_clean_part(parts[4])
        tokens['project'].value = proj
        tokens['display'].value = f'{proj} - {tech} {libr}'
    else:
        raise ValueError(package)

    tokens['author'].value = 'Appalachia Interactive'

    license_index = get_license(internal_license_options)
    tokens['license'].value = internal_license_options[license_index]


def package_thirdparty(package, parts):
    if len(parts) == 5:
        #com.appalachia.technology.author.library
        tech = get_clean_part(parts[3])
        auth = get_clean_part(parts[4])
        libr = get_clean_part(parts[5])
        tokens['author'].value = auth
        tokens['display'].value = f'{tech} {libr}'
    elif len(parts) == 6:
        #com.appalachia.project.technology.author.library
        proj = get_clean_part(parts[2])
        tech = get_clean_part(parts[3])
        auth = get_clean_part(parts[4])
        libr = get_clean_part(parts[5])
        tokens['project'].value = proj
        tokens['author'].value = auth
        tokens['display'].value = f'{proj} - {tech} {libr}'
    else:
        raise ValueError(package)
    
    license_index = get_license(external_license_options)
    tokens['license'].value = external_license_options[license_index]


def package_unitytechnologies(package, parts):
    if len(parts) == 5:
        #com.appalachia.unity3d.unity.library
        libr = get_clean_part(parts[5])
        tokens['display'].value = f'{libr}'
    elif len(parts) == 6:
        #com.appalachia.project.unity3d.unity.library
        proj = get_clean_part(parts[2])
        libr = get_clean_part(parts[5])
        tokens['project'].value = proj
        tokens['display'].value = f'{proj} - {libr}'
    else:
        raise ValueError(package)

    tokens['author'].value = 'Unity Technologies'
    
    license_index = get_license(unity_license_options)
    tokens['license'].value = unity_license_options[license_index]


def package_assetstore(package, parts):   
    if len(parts) == 5:
        #com.appalachia.unity3d.author.library
        tech = get_clean_part(parts[3])
        auth = get_clean_part(parts[4])
        libr = get_clean_part(parts[5])
        tokens['author'].value = auth
        tokens['display'].value = f'{tech} {libr}'
    elif len(parts) == 6:
        #com.appalachia.project.unity3d.author.library
        proj = get_clean_part(parts[2])
        tech = get_clean_part(parts[3])
        auth = get_clean_part(parts[4])
        libr = get_clean_part(parts[5])
        tokens['project'].value = proj
        tokens['author'].value = auth
        tokens['display'].value = f'{proj} - {tech} {libr}'
    else:
        raise ValueError(package)

    tokens['license'].value = 'ASEULA'

def copy_files(template):
    print(template)
    for dirpath, dirnames, filenames in os.walk(template):
        for dirname in dirnames:
            path = os.path.join(dirpath, dirname)   
            print(path) 

            if DRY_RUN:
                continue

            shutil.copy(path, f'./{dirname}')

        for filename in filenames:
            path = os.path.join(dirpath, filename)  
            print(path) 

            if DRY_RUN:
                continue

            shutil.copy(path, f'./{filename}')
        break

def confirm_execution():
    print("\n")
    print("Please confirm your choices:")
    print("----------------------------")
    print("\n")
    for token_key in tokens.keys():
        print(f'{token_key.title()}: [{tokens[token_key].value}]')

    print('----------------------------')

    return do_ask('Would you like to proceed?')

def execute():
          
    tokens['version'].value = default_version
    directory = get_directory()
    package = get_package(directory)
         
    tokens['package'].value = package

    package_type_index = do_selection(package_types, 'Select the package type')
    package_type = package_types[package_type_index]

    category_index = do_selection(categories, 'Select the package category')
    category = categories[category_index]

    parts = package.split('.')
    package_proc = 'package_{0}'.format(package_type.replace('-','').replace(' ','').lower())
    eval('{0}(package, parts)'.format(package_proc))

    description = do_parameter('Enter a package description', no_validation)
    tokens['description'].value = do_ask_until_confirmed(description, 'Is this the package description? [{0}]', 'Enter a package description', no_validation)
    
    if not confirm_execution():
        return
    
    template_folder = os.path.join(
        os.getenv("HOME"),
        category_templates[category_index])

    copy_files(template_folder)

    if category == 'General':    
        process_token_replacements()  
        process_license(package_type == 'Appalachia Interactive')
        process_repository(directory, package)
        process_workspace(package)

    elif category == 'Unity Project':
        process_token_replacements()  
        process_license(package_type == 'Appalachia Interactive')
        process_repository(directory, package)
        process_workspace(package)

    elif category == 'Unity Package':
        process_token_replacements()  
        process_license(package_type == 'Appalachia Interactive')
        process_repository(directory, package)
        process_workspace(package)

    return

print('Enter x to exit.')
execute()