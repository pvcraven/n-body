#version 330

in vec4 in_vertex;
in vec4 in_color;

out vec2 vertex_pos;
out float vertex_radius;
out vec4 vertex_color;
out float v_strength;

void main()
{
    vertex_pos = in_vertex.xy;
    v_strength = smoothstep(-600, 600, in_vertex.z) + .2;
    vertex_radius = in_vertex.w;
    vertex_color = in_color;
}