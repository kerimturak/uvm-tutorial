class component_base;
  
  string name;
  component_base parent;

  function new(string name  = "", component_base parent = null);
    this.name = name;
    this.parent = parent;
  endfunction

/*
tree traversal

parent chain traversal
*/
  function string pathname();

    component_base ptr = this;

    pathname = name;

    while (ptr.parent != null) begin
      ptr = ptr.parent;
      pathname = {ptr.name, ".", pathname};
    end

  endfunction
endclass