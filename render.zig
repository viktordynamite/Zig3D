const std = @import("std");
const Math = @import("math.zig");

pub const Renderer = struct {
    pub fn renderPoint(point: Math.Vec3) void {
        const screen_x = point.x;
        const screen_y = point.y;

        std.debug.print("Point at ({}, {}\n)", .{ screen_x, screen_y });
    }
};
