class UtilStorage {
  UtilStorage._();

  static const currentUser = 'current.user';
  static const savedNamesId = 'saved.names.id';
  static const customNames = 'custom.names';
  static const customNameLastId = 'custom.name.last.id';
  static const hospitalBagItems = 'hospital.bag.items';
  static const hospitalBagLastId = 'hospital.bag.last.id';
  static const movementItems = 'movement.items';
  static const contractionItems = 'contraction.items';
  static const tummySizeItems = 'tummy.size.items';
  static const myWeightItems = 'my.weight.items';
  static const daysItems = 'days.items';
  static const dailyAdvicesItems = 'daily.advices.items';
  static const savedArticles = 'saved.articles';
  static const weeklyAdvicesShown = 'weekly.advices.shown';
  static const firstRun = 'first.run';

  static shoppingListItems(String listName) => '$listName.list.items';

  static shoppingListLastId(String listName) => '$listName.list.last.id';
}
