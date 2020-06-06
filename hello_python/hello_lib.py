from collections import OrderedDict

fav_languages = OrderedDict()

fav_languages["jen"] = "Python"
fav_languages["sarah"] = "c"
fav_languages["edward"] = "ruby"
fav_languages["phil"] = "python"

for name, language in fav_languages.items():
    print(name.title() + "'s favorite language is " + language.title() + ".")
