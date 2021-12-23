#version 330

in vec2 g_uv;
in vec3 g_color;
in float g_strength;

out vec4 out_color;

void main()
{
    float l = length(vec2(0.5, 0.5) - g_uv.xy);
    if ( l > 0.5)
    {
        discard;
    }
    float alpha;
    if (l == 0.0)
        alpha = g_strength;
    else {
        alpha = min(1.0, g_strength - (l * 2));
    }
    vec3 c = g_color.rgb;
    // c.xy += v_uv.xy * 0.05;
    // c.xy += v_pos.xy * 0.75;
    out_color = vec4(c, alpha);
}
