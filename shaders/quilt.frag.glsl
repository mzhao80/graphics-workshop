precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    gl_FragColor = vec4(0.9, 0.9, 0.9, 1.0);

    vec2 coord = gl_FragCoord.xy / resolution;
    //float dist_to_center = length(coord - vec2(0.5, 0.5));
    //float blue = 0.2 * (1.0 - sin(dist_to_center * 80.0));
    //float blue2 = 1.0 - 1e5 * pow(dist_to_center - 0.5, 2.0);
    //gl_FragColor = vec4(coord, blue2, 1.0);

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.y + vec2(time);
    vec2 loc = fract(squareCoord);
    color = vec3(smoothstep(-0.05, 0.05, loc.y - loc.x));

    // 2. Uncomment these lines to invert some of the triangles
    vec2 cell = squareCoord - loc;
    if (mod(2.0 * cell.x + cell.y, 5.0) == 1.0) {
        color = 1.0 - color;
    }

    // 3. Uncomment these lines to produce interesting colors
    float c = mod(3.0 * cell.x + 2.0 * cell.y, 7.0) / 7.0;
    color = 1.0 - (1.0 - color) * vec3(c, c, c);

    // 4. Uncomment to lighten the colors
    color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
