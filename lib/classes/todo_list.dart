/// Enum comportant l'ensemble des thèmes de notre TODO List
enum CategoryEnum { shopping, sport, work }

/// Classe abstraite servant à concevoir les Tâches de la TODO List
abstract class Task {
  String name = "";
  bool done = false;
  CategoryEnum category;
  
  Task(this.name, this.category);
  
  @override
  String toString() {
    return "{name: $name, category: $category}";
  }
}

/// Classe implémentant [Task] et appartenant à la catégorie [CategoryEnum.shopping]
class Shopping extends Task {
  Shopping(String name) : super(name, CategoryEnum.shopping);
}

/// Classe implémentant [Task] et appartenant à la catégorie [CategoryEnum.sport]
class Sport extends Task {
  Sport(String name) : super(name, CategoryEnum.sport);
}

/// Classe implémentant [Task] et appartenant à la catégorie [CategoryEnum.work]
class Work extends Task {
  Work(String name) : super(name, CategoryEnum.work);
}

/// Effectue une recherche dans une [taskList] d'une [category].
///
/// Retourne les 3 premiers résutats.
List<Task> whereThreeTasks(List<Task> taskList, CategoryEnum category) {
  List<Task> result = taskList.where((el) => el.category == category).toList();
  return result.sublist(0, result.length > 3 ? 3 : result.length);
}

/// Permet de parcourir une [taskList], afin d'afficher le titre de la tâche
/// et trois de ses tâches.
void renderPrompt(List<Task> taskList) {
  for (CategoryEnum category in CategoryEnum.values) {
    List<Task> aList = whereThreeTasks(taskList, category);
    if (aList.isNotEmpty) {
      print(category.name);
      for (Task task in aList) {
        print('> ${task.name}');
      }
    } else {
      print('${category.name}: Nothing to do.');
    }
  }
}

void main() {
  List<Task> taskList = [];
  taskList.add(Shopping("Kinder Bueno"));
  taskList.add(Sport("Triathlon"));
  taskList.add(Shopping("KitKat"));
  taskList.add(Sport("Trail"));
  taskList.add(Shopping("Nesquik"));
  taskList.add(Shopping("Mars"));
  taskList.add(Shopping("Twix"));
  taskList.add(Sport("Marathon"));
  taskList.add(Shopping("Bounty"));
  renderPrompt(taskList);
}