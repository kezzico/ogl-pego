attribute vec4 vert;
attribute vec3 normal;
attribute vec2 tvert;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec4 tint;
varying vec2 ftvert;

void main() {
  ftvert = tvert;
  gl_Position = modelViewProjectionMatrix * vert;
}
