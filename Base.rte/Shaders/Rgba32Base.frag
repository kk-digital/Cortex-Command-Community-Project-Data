#version 330 core

in vec2 textureUV;

out vec4 FragColor;

uniform sampler2D rteTexture;
uniform vec4 rteColor;

uniform float time;
void main() {
  vec4 color = texture(rteTexture, textureUV);
  FragColor = color * rteColor;
}
