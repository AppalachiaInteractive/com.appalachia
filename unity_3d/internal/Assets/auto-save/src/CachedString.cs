using UnityEditor;

namespace Appalachia.Internal.AutoSave
{
    public class CachedString : Cached<string>
    {
        public CachedString(string key, string defaultValue) : base(key, defaultValue)
        {
        }
            
        protected override string Get(string key, string defaultValue)
        {
            var value = EditorPrefs.GetString(key, defaultValue);
            return value;
        }

        protected override void Set(string key, string value)
        {
            EditorPrefs.SetString(key, value);
        }
    }
}
