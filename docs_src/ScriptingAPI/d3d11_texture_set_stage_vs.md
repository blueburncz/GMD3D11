# d3d11_texture_set_stage_vs

<span class="badge badge-secondary">function</span>

```gml
d3d11_texture_set_stage_vs(_slot, _texture)
```

## Description
Passes a texture to a vertex shader.

## Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| _slot | `Real` | The vertex texture slot index. Must be in range 0..[D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT](D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT.html)-1. |
| _texture | `Pointer.Texture` | The texture to pass. |

## Returns
`Real` Returns 1 on success or 0 on fail.