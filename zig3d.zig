const std = @import("std");
const c = @cImport({
    @cInclude("SDL.h");
});

pub const Renderer = struct {
    pub fn init(width: i32, height: i32) !Renderer {
        if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
            return error.SDLInitFailed;
        }
        defer c.SDL_Quit();

        const window = c.SDL_CreateWindow("Zig 3D", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, width, height, c.SDL_WINDOW_SHOWN) orelse {
            return error.SDLWindowCreationFailed;
        };
        defer c.SDL_DestroyWindow(window);

        const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_ACCELERATED) orelse {
            return error.SDLRendererCreationFailed;
        };
        defer c.SDL_DestroyRenderer(renderer);

        return Renderer{
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

    window: *c.SDL_Window,
    renderer: *c.SDL_Renderer,
};

pub const Zig3D = struct {
    renderer: Renderer,

    pub fn init() !Zig3D {
        return Zig3D{
            .renderer = try Renderer.init(800, 600),
        };
    }

    pub fn deinit(self: *Zig3D) void {
        self.renderer.deinit();
    }

    pub fn run(self: *Zig3D) !void {
        self.renderer.clear(255);
        self.renderer.present();

        c.SDL_Delay(3000);
    }
};
