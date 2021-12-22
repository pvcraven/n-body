#version 430

layout(local_size_x=COMPUTE_SIZE_X, local_size_y=COMPUTE_SIZE_Y) in;

uniform vec2 screen_size;
//uniform vec2 force;
//uniform float frame_time;

struct Ball
{
    vec4 pos;
    vec4 vel;
    vec4 col;
};

layout(std430, binding=0) buffer balls_in
{
    Ball balls[];
} In;
layout(std430, binding=1) buffer balls_out
{
    Ball balls[];
} Out;

void main()
{
    int x = int(gl_GlobalInvocationID);

    Ball in_ball = In.balls[x];

    vec4 p = in_ball.pos.xyzw;
    vec4 v = in_ball.vel.xyzw;

    p.xy += v.xy;

    for (int i=0; i < In.balls.length(); i++) {
//        if (i == x)
//            continue;
        float d2 = distance(In.balls[i].pos.xyzw.xy, p.xy);
        d2 = d2 * d2;
        float d = min(0.02, .3 / d2) * -.002;

        vec2 diff = p.xy - In.balls[i].pos.xyzw.xy;
        vec2 delta_v = diff * d;
        v.xy += delta_v;
    }

    Ball out_ball;
    out_ball.pos.xyzw = p.xyzw;
    out_ball.vel.xyzw = v.xyzw;

    vec4 c = in_ball.col.xyzw;
    out_ball.col.xyzw = c.xyzw;

    Out.balls[x] = out_ball;
}
