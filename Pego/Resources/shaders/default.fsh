uniform sampler2D texture;
uniform mediump vec4 tint;

varying mediump vec2 ftvert;

void main() {
  mediump vec4 texel = texture2D(texture, ftvert) * tint;
  if(texel.a < 0.001) discard;
  gl_FragColor = texel;
}

