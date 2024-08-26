const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
});

pub const Renderer = struct {
    width: u32,
    height: u32,
    window: *c.SDL_Window,
    renderer: *c.SDL_Renderer,

    pub fn init(width: u32, height: u32) !Renderer {
        if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
            std.debug.print("SDL_Init Error: {s}\n", .{c.SDL_GetError()});
            return error.SDLInitFailed;
        }

        const window = c.SDL_CreateWindow("My SDL Window", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, width, height, c.SDL_WINDOW_SHOWN) orelse {
            std.debug.print("SDL_CreateWindow Error: {s}\n", .{c.SDL_GetError()});
            c.SDL_Quit();
            return error.SDLWindowCreationFailed;
        };

        const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_ACCELERATED) orelse {
            std.debug.print("SDL_CreateRenderer Error: {s}\n", .{c.SDL_GetError()});
            c.SDL_DestroyWindow(window);
            c.SDL_Quit();
            return error.SDLRendererCreationFailed;
        };

        return Renderer{
            .width = width,
            .height = height,
            .window = window,
            .renderer = renderer,
        };
    }

    pub fn deinit(self: *Renderer) void {
        c.SDL_DestroyRenderer(self.renderer);
        c.SDL_DestroyWindow(self.window);
        c.SDL_Quit();
    }

    pub fn clear(self: *Renderer, color: u8) void {
        c.SDL_SetRenderDrawColor(self.renderer, color, color, color, 255);
        c.SDL_RenderClear(self.renderer);
    }

    pub fn present(self: *Renderer) void {
        c.SDL_RenderPresent(self.renderer);
    }
};

pub fn main() anyerror!void {
    var renderer = try Renderer.init(800, 600);
    defer renderer.deinit();

    renderer.clear(255);
    renderer.present();

    c.SDL_Delay(3000);
}
