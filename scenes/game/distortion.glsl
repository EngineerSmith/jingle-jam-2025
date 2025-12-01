#ifdef VERTEX

uniform float curveStrength = 0.02;

vec4 position( mat4 transform_projection, vec4 vertex_position )
{
  vec2 screenCenter = love_ScreenSize.xy / 2.0;
  float maxRadius = length(screenCenter);

  vec2 worldPos = vertex_position.xy;
  vec2 centreToVertex = worldPos - screenCenter;
  float dist = length(centreToVertex);
  float normDist = dist / maxRadius;

  float distortion = curveStrength * pow(normDist, 2.0);
  vec2 offset = centreToVertex * distortion;

  vec2 newPos = worldPos - offset;
  vec4 newVertexPos = vec4(newPos, vertex_position.zw);

  return transform_projection * newVertexPos;
}

#endif