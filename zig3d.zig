const std = @import("std");
const Math = @import("math.zig");
const Renderer = @import("render.zig").Renderer;

pub const Zig3D = struct {
    is_running: bool,
    renderer: Renderer,
    last_time: i64,

    pub fn init() !Zig3D {
        return Zig3D{
            .is_running = true,
            .renderer = try Renderer.init(800, 600),
            .last_time = std.time.milliTimestamp(),
        };
    }

    pub fn run(self: *Zig3D) !void {
        while (self.is_running) {
            try self.processInput();
            try self.update();
            try self.render();

            if (std.time.milliTimestamp() - self.last_time < 16) {
                std.time.sleep(16 * std.time.ns_per_ms);
            }
            self.last_time = std.time.milliTimestamp();
        }
    }

    fn processInput(self: *Zig3D) !void {

        // self.is_running = !quit_requested;

        @unused self;
    }

    fn update(self: *Zig3D) !void {
        // Update game state, physics, etc.
        @unused self;
    }

    fn render(self: *Zig3D) !void {
        self.renderer.clear(0x000000); 

        // Example: render a point
        const point = Math.Vec3{ .x = 400, .y = 300, .z = 0 };
        self.renderer.renderPoint(point, 0xFFFFFF);
        self.renderer.present();
    }

    pub fn cleanup(self: *Zig3D) void {
        self.renderer.deinit();
    }
};
