/usr/bin/mogenerator -m "Project/Models/CoreData/Model.xcdatamodeld/Model.xcdatamodel" -O Project/Models/CoreData/Entity/ --template-var arc=true
ruby tools/UserDefaultsCreator.rb Project/Models/UserDefaults/UserDefaults.h Project/Models/UserDefaults/ -f UserDefaults -i
ruby tools/extractingId.rb Project/Storyboard/Main.storyboard Project/Storyboard/