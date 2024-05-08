#version 330 core
out vec4 FragColor;
in vec2 fragTexCoord;

uniform float u_time; // Passed from your game to animate the shader
uniform vec2 u_resolution; // Screen resolution

// Function to create pseudo-random number based on a coordinate
float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

// Function to blend colors
vec3 blendOverlay(vec3 base, vec3 blend) {
    return mix(1.0 - 2.0 * (1.0 - base) * (1.0 - blend), 2.0 * base * blend, step(base, vec3(0.5)));
}

vec3 colourA = vec3(0.149, 0.141, 0.131);
vec3 colourB = vec3(0.021, 0.033, 0.024);

// Main function to draw Milky Way
void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec2 p = uv;
    p-=abs(sin(u_time + .5));

    vec3 col = vec3(0.0, 0.0, ceil(p.y));
 
    // Output the color
    FragColor = vec4(col,1.0);
}
