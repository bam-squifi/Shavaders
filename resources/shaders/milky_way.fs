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

// Main function to draw Milky Way
void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    
    float y = sin(uv.x)

    vec3 col = vec3(y);

    col = abs(uv.y - uv.x)*col;

    // Output the color
    FragColor = vec4(vec3(y),1.0);
}
