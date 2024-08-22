const std = @import("std");
const Math = @import("math.zig");

pub const Renderer = struct {
    width: u32,
    height: u32,
    buffer: []u32,

    pub fn init(width: u32, height: u32) !Renderer {
        return Renderer{
            .width = width,
            .height = height,
            .buffer = try std.heap.page_allocator.alloc(u32, width * height),
        };
    }

    pub fn deinit(self: *Renderer) void {
        std.heap.page_allocator.free(self.buffer);
    }

    pub fn clear(self: *Renderer, color: u32) void {
        for (self.buffer) |*pixel| {
            pixel.* = color;
        }
    }

    pub fn renderPoint(self: *Renderer, point: Math.Vec3, color: u32) void {
        const x = @floatToInt(u32, point.x);
        const y = @floatToInt(u32, point.y);

        if (x < self.width and y < self.height) {
            self.buffer[y * self.width + x] = color;
        }
    }

    pub fn renderLine(self: *Renderer, start: Math.Vec3, end: Math.Vec3, color: u32) void {
        // Implement line drawing algorithm
    }

    pub fn renderTriangle(self: *Renderer, v1: Math.Vec3, v2: Math.Vec3, v3: Math.Vec3, color: u32) void {
        // Implement triangle rasterization
    }

    pub fn present(self: *Renderer) void {
        for (0..self.height) |y| {
            for (0..self.width) |x| {
                const color = self.buffer[y * self.width + x];
                if (color != 0) {
                    std.debug.print("#", .{});
                } else {
                    std.debug.print(".", .{});
                }
            }
            std.debug.print("\n", .{});
        }
    }
};
