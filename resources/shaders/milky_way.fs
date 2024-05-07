#version 330 core
out vec4 FragColor;
in vec2 fragTexCoord;

uniform float u_time; // Passed from your game to animate the shader
uniform vec2 u_resolution; // Screen resolution

// Main function to draw Milky Way
void main()
{
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    

    // Output the color
    FragColor = vec4(uv.x, uv.y, 0.0,1.0);
}
