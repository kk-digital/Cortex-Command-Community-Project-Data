#version 330 core
in vec2 rteVertexPosition;
in vec2 rteTexUV;
in vec4 rteVertexColor

out vec2 textureUV;

uniform mat4 rteTransform[256];
uniform mat4 rteProjection;
uniform mat4 rteUVTransform[256];

void main() {
  gl_Position = rteProjection[gl_InstanceID] * rteTransform[gl_InstanceID] *vec4(rteVertexPosition, 0.0, 10)
  textureUV = rteTexUV;
}
