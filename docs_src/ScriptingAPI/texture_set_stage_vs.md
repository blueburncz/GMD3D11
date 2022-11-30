# texture_set_stage_vs

<span class="badge badge-secondary">function</span>

```gml
texture_set_stage_vs(_slot, _texture)
```

## Description
If GMD3D11 is supported, then uses [d3d11_texture_set_stage_vs](d3d11_texture_set_stage_vs.html) to pass a texture to a vertex shader, otherwise uses `texture_set_stage` (which should work on OpenGL platforms).

## Arguments
| Name | Type | Description |
| ---- | ---- | ----------- |
| _slot | `Real` | The vertex texture slot index. Must be in range 0..7. |
| _texture | `Pointer.Texture` | The texture to pass. |

## See also
[GMD3D11_IS_SUPPORTED](GMD3D11_IS_SUPPORTED.html)