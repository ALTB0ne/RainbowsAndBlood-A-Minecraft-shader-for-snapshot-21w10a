#version 150

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;
uniform float GameTime;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec2 texCoord2;
out vec4 normal;

void main() {
    vec3 position = Position + ChunkOffset;
    float animation = GameTime * 6000.0;

    float xs = 0.0;
    float zs = 0.0;
    if (UV0.x >= 224.0 / 1024.0 && UV0.x <= 240.0 / 1024.0) {
        if (UV0.y >= 400.0 / 1024.0 && UV0.y <= 416.0 / 1024.0) {
            xs = sin(position.x + animation);
            zs = cos(position.z + animation);
        }
    }

    gl_Position = ProjMat * ModelViewMat * (vec4(position, 1.0) + vec4(0.0, (xs - zs) / 32.0, 0.0, 0.0));

    vertexDistance = length((ModelViewMat * vec4(Position + ChunkOffset, 1.0)).xyz);
    float colorModifier = 0.0;
    colorModifier = 8 * (1 / vertexDistance) * (1 / vertexDistance);
    vertexColor = (Color + vec4(colorModifier, -colorModifier, -colorModifier, 0.0)) * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
}
