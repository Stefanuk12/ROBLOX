# ESP:Box
```lua
<<Box> Object> ESP:Box(<table> Data)
```
Creates a new ESP Box Object.

## Parameters
* `table` Data
> A table that configures the new ESP Box Object.

| Field   | Type                      | Description                                                                                |
| ------- | ------------------------  | ------------------------------------------------------------------------------------------ |
| `Model` | `Instance (Model / Part)` | Despite being called `Model`, you may also supply a part to it as well                     |
| `Data`  | `ObjectData`              | This is the data for the Drawing Object, please only supply valid indexes or it will break |

## ObjectData
Please refer to [this](https://x.synapse.to/docs/reference/drawing_lib.html#quad) for the possible indexes and values you can put for `ObjectData`

## Returns
* `Box` Object

[Source](https://github.com/Stefanuk12/ROBLOX/blob/master/Universal/ESP/Rewrite.lua#L236)