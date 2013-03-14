uniform sampler2D texture;
uniform mediump vec4 tint;

varying mediump vec2 ftvert;

void main() {
  gl_FragColor = texture2D(texture, ftvert) * tint;
}

