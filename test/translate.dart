 Registers this build context with [ancestor] such that when
 [ancestor]'s widget changes this build context is rebuilt.

 Returns `ancestor.widget`.

 This method is rarely called directly. Most applications should use
 [inheritFromWidgetOfExactType], which calls this method after finding
 the appropriate [InheritedElement] ancestor.

 All of the qualifications about when [inheritFromWidgetOfExactType] can
 be called apply to this method as well.