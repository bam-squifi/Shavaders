#version 330 core
out vec4 FragColor;
in vec2 fragCoord;

uniform float u_time; // Passed from your game to animate the shader
uniform vec2 resolution; // Screen resolution

// Main function to draw Milky Way
void main()
{
    vec2 uv = fragCoord / resolution;
    

    // Output the color
    FragColor = vec4(vec3(abs(sin(u_time)) + 0.5),1.0);
}
