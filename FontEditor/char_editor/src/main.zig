const std = @import("std");
const sdl = @cImport({
    @cInclude("SDL3/SDL.h");
});

var WIDTH: u16 = 500;
var HEIGHT: u16 = 500;

var quit: bool = false;

// Used for SDL_FRect
const Rect = packed struct { x: f32, y: f32, w: f32, h: f32 };

var table: [256]u64 = undefined;

pub const FONT_A: u64 = @as(u64, @bitCast(@as(c_long, 4352278784536462275)));
pub const FONT_B: u64 = 18213616809356280828;
pub const FONT_C: u64 = @as(u64, @bitCast(@as(c_long, 4593883554018017343)));
pub const FONT_D: u64 = 17351458709922106608;
pub const FONT_E: u64 = 18446674804472872959;
pub const FONT_F: u64 = 18446674804472856768;
pub const FONT_G: u64 = @as(u64, @bitCast(@as(c_long, 9223302625347486718)));
pub const FONT_H: u64 = 14106333962129621955;
pub const FONT_I: u64 = 18446489090495414271;
pub const FONT_J: u64 = @as(u64, @bitCast(@as(c_long, 217020518514230268)));
pub const FONT_K: u64 = 14397120638141123783;
pub const FONT_L: u64 = 13889313184910721279;
pub const FONT_M: u64 = 14116532876766069699;
pub const FONT_N: u64 = 14115393885800484807;
pub const FONT_O: u64 = @as(u64, @bitCast(@as(c_long, 9151248213410578302)));
pub const FONT_P: u64 = 18374620251275837632;
pub const FONT_Q: u64 = @as(u64, @bitCast(@as(c_long, 9151248213414477315)));
pub const FONT_R: u64 = 18357732005822123207;
pub const FONT_S: u64 = @as(u64, @bitCast(@as(c_long, 9205569002326393854)));
pub const FONT_T: u64 = 18446489090495354904;
pub const FONT_U: u64 = 14106333703424951166;
pub const FONT_V: u64 = 14106333302423829528;
pub const FONT_W: u64 = 14106333703829186499;
pub const FONT_X: u64 = 14106230866751964099;
pub const FONT_Y: u64 = 14106230866142828568;
pub const FONT_Z: u64 = 18446470426191265791;
pub const FONT_0: u64 = 18411139144890810879;
pub const FONT_1: u64 = @as(u64, @bitCast(@as(c_long, 1736164148113840152)));
pub const FONT_2: u64 = @as(u64, @bitCast(@as(c_long, 9116136719743213823)));
pub const FONT_3: u64 = 18159077807387378428;
pub const FONT_4: u64 = 9331882835121864961;
pub const FONT_5: u64 = 18410857109412446719;
pub const FONT_6: u64 = @as(u64, @bitCast(@as(c_long, 8971311748128866940)));
pub const FONT_7: u64 = 18374970170986733632;
pub const FONT_8: u64 = @as(u64, @bitCast(@as(c_long, 9115709501113205118)));
pub const FONT_9: u64 = @as(u64, @bitCast(@as(c_long, 9115709503252267265)));
pub const FONT_COLON: u64 = @as(u64, @bitCast(@as(c_long, 6781788124348416)));
pub const FONT_CHAR_TABLE: [256]u64 = [91]u64{
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    FONT_0,
    FONT_1,
    FONT_2,
    FONT_3,
    FONT_4,
    FONT_5,
    FONT_6,
    FONT_7,
    FONT_8,
    FONT_9,
    FONT_COLON,
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    @import("std").mem.zeroes(u64),
    FONT_A,
    FONT_B,
    FONT_C,
    FONT_D,
    FONT_E,
    FONT_F,
    FONT_G,
    FONT_H,
    FONT_I,
    FONT_J,
    FONT_K,
    FONT_L,
    FONT_M,
    FONT_N,
    FONT_O,
    FONT_P,
    FONT_Q,
    FONT_R,
    FONT_S,
    FONT_T,
    FONT_U,
    FONT_V,
    FONT_W,
    FONT_X,
    FONT_Y,
    FONT_Z,
} ++ [1]u64{@import("std").mem.zeroes(u64)} ** 165;

fn decompile(grid: *[8][8]bool, val: u64) void {
    for (0..8) |y| {
        for (0..8) |x| {
            grid[y][x] = (val >> @truncate(63 - (y * 8 + x))) & 1 == 1;
        }
    }
}

fn compile(grid: [8][8]bool) u64 {
    var new_number: u64 = 0;

    for (0..8) |y| {
        for (0..8) |x| {
            new_number <<= 1;
            new_number += @intCast(@as(u1, @bitCast(grid[y][x])));
        }
    }

    return new_number;
}

pub fn main() !void {
    // First arg is self, second arg should be a file that points to a table
    var args = std.process.args();
    defer args.deinit();
    _ = args.skip();
    const val_str = args.next();

    if (val_str == null) {
        return;
    }

    var grid: [8][8]bool = undefined;
    var current_key: u8 = undefined;

    //@memcpy(&table, &FONT_CHAR_TABLE);

    //
    // I wish there was a better way of doing this, maybe by direct bitcasts or something.
    var file: std.fs.File = try std.fs.cwd().openFile(val_str.?, std.fs.File.OpenFlags{ .mode = .read_write }); //14397120638141123783;
    defer file.close();

    const reader = file.reader();
    for (&table) |*item| {
        item.* = try reader.readInt(u64, std.builtin.Endian.little);
    }

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
    const renderer = sdl.SDL_CreateRenderer(window, null) orelse {
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
                    switch (event.key.key) {
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
                        else => |key| {
                            //std.debug.print("key pressed: {c}\nentry: {d}\n", .{ @as(u8, @intCast(key)), table[@intCast(key)] });
                            if (key >= 0 and key < 256) {
                                if (97 <= key and key <= 122) {
                                    decompile(&grid, table[@intCast(key - 32)]);
                                    current_key = @intCast(key - 32);
                                } else {
                                    decompile(&grid, table[@intCast(key)]);
                                    current_key = @intCast(key);
                                }
                            }
                        },
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

                    // std.debug.print("Old: {}\n", .{table[current_key]});
                    table[current_key] = compile(grid);
                    // std.debug.print("New: {}\n", .{table[current_key]});
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

    //std.debug.print("{}\n", .{new_number});
    //try file.writer().writeStruct(table);
    //try file.writeAll(@ptrCast(&table));
    //table[255] = 0x72727272;
    try file.seekTo(0);
    const writer = file.writer();
    //std.debug.print("{}\n", .{table['1']});
    for (table) |item| {
        // std.debug.print("{}\n", .{item});
        try writer.writeInt(u64, item, std.builtin.Endian.little);
    }
    try file.sync();
}
