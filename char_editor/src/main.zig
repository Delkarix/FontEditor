const std = @import("std");
const sdl = @cImport({
    @cInclude("SDL3/SDL.h");
});

var WIDTH: u16 = 500;
var HEIGHT: u16 = 500;

var quit: bool = false;
var grid: [8][8]bool = undefined;

// Used for SDL_FRect
const Rect = packed struct { x: f32, y: f32, w: f32, h: f32 };

pub fn main() !void {
    var args = std.process.args();
    defer args.deinit();
    _ = args.skip();
    const val_str = args.next() orelse "0";

    // Convert number into bitarray
    // I wish there was a better way of doing this, maybe by direct bitcasts or something.
    const val: u64 = try std.fmt.parseInt(u64, val_str, 10); //14397120638141123783;
    for (0..8) |y| {
        for (0..8) |x| {
            grid[y][x] = (val >> @truncate(63 - (y * 8 + x))) & 1 == 1;
        }
    }
    // grid = @bitCast(val);

    // Initialize SDL
    if (sdl.SDL_Init(sdl.SDL_INIT_VIDEO) != 0) {
        return error.SDLInitFailed;
    }
    defer sdl.SDL_Quit();

    // Create the window
    const window = sdl.SDL_CreateWindow("Character Editor", WIDTH, HEIGHT, sdl.SDL_WINDOW_RESIZABLE | sdl.SDL_WINDOW_OPENGL) orelse {
        return error.SDLInitFailed;
    };
    defer sdl.SDL_DestroyWindow(window);

    // Create renderer
    const renderer = sdl.SDL_CreateRenderer(window, null, sdl.SDL_RENDERER_ACCELERATED) orelse {
        return error.SDLInitFailed;
    };
    defer sdl.SDL_DestroyRenderer(renderer);

    // Main loop
    while (!quit) {
        var event: sdl.SDL_Event = undefined;
        while (sdl.SDL_PollEvent(&event) != 0) {
            switch (event.type) {
                sdl.SDL_EVENT_QUIT => {
                    quit = true;
                },
                sdl.SDL_EVENT_KEY_DOWN => {
                    switch (event.key.keysym.sym) {
                        // sdl.SDLK_s => {
                        //     // Save
                        //     // TODO
                        //     sdl.SDL_Log("Pressed S\n");
                        // },
                        sdl.SDLK_ESCAPE => {
                            // Quit
                            quit = true;
                        },
                        // sdl.SDLK_o => {
                        //     // Open
                        //     // TODO
                        // },
                        else => {},
                    }
                },
                // sdl.EVENT_KEY_UP => {},
                sdl.SDL_EVENT_MOUSE_BUTTON_DOWN => {
                    var x_temp: f32 = undefined;
                    var y_temp: f32 = undefined;
                    _ = sdl.SDL_GetMouseState(&x_temp, &y_temp);

                    const x: u16 = @intFromFloat(8 * x_temp / @as(f32, @floatFromInt(WIDTH)));
                    const y: u16 = @intFromFloat(8 * y_temp / @as(f32, @floatFromInt(HEIGHT)));

                    grid[y][x] = !grid[y][x];
                },
                sdl.SDL_EVENT_WINDOW_RESIZED => {
                    WIDTH = @intCast(event.window.data1);
                    HEIGHT = @intCast(event.window.data2);
                },
                else => {},
            }
        }

        // Process logic
        _ = sdl.SDL_SetRenderDrawColor(renderer, 0, 0, 0, 0);
        _ = sdl.SDL_RenderClear(renderer);
        _ = sdl.SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);

        // Draw horizontal lines
        for (1..8) |i| {
            _ = sdl.SDL_RenderLine(renderer, 0, @floatFromInt(i * HEIGHT / 8), @floatFromInt(WIDTH), @floatFromInt(i * HEIGHT / 8));
        }
        // Draw vertical lines
        for (1..8) |i| {
            _ = sdl.SDL_RenderLine(renderer, @floatFromInt(i * WIDTH / 8), 0, @floatFromInt(i * WIDTH / 8), @floatFromInt(HEIGHT));
        }

        // Draw boxes
        for (0..8) |y| {
            for (0..8) |x| {
                if (grid[y][x]) {
                    _ = sdl.SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
                    //const rect = Rect{ .x = @floatFromInt(WIDTH * x), .y = @floatFromInt(HEIGHT * y), .w = @as(f32, @floatFromInt(WIDTH)) / 8.0, .h = @as(f32, @floatFromInt(HEIGHT)) / 8.0 };
                    var rect: sdl.SDL_FRect = undefined;
                    rect.x = @floatFromInt(WIDTH / 8 * x);
                    rect.y = @floatFromInt(HEIGHT / 8 * y);
                    rect.w = @as(f32, @floatFromInt(WIDTH)) / 8;
                    rect.h = @as(f32, @floatFromInt(HEIGHT)) / 8;
                    _ = sdl.SDL_RenderFillRect(renderer, &rect);
                }
            }
        }

        _ = sdl.SDL_RenderPresent(renderer);
    }

    // Convert bitarray back into number
    var new_number: u64 = 0;

    for (0..8) |y| {
        for (0..8) |x| {
            new_number <<= 1;
            new_number += @intCast(@as(u1, @bitCast(grid[y][x])));
        }
    }

    std.debug.print("{}\n", .{new_number});
}
