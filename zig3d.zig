const std = @import("std");
const Math = @import("math.zig");
const Renderer = @import("render.zig");

pub const Zig3D = struct {
    is_running: bool,

    pub fn init() Zig3D {
        return Zig3D{
            .is_running = true,
        };
    }

    pub fn run(self: *Zig3D) void {
        const point = Math.Vec3{ .x = 1.0, .y = 2.0, .z = 3.0 };
        Renderer.renderPoint(point);

        self.is_running = false;
    }

    pub fn cleanup(self: *Zig3D) void {
        _ = @unused self;
    }
};
