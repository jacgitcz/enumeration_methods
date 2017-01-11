# enum_methods
Odin Project : Ruby : Advanced Building Blocks : Enumeration Methods

Added Rspec tests, modified some methods to behave in the absence of a block.  NB Enumerable spec requires that in
some cases of a missing block, an enumerator is returned.  This gets a bit messy, so my enumerables just return the original collection in this case.