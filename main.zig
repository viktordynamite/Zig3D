const std = @import("std");
const Zig3D = @import("zig3d.zig");

pub fn main() !void {
    std.debug.print("Initializing Zig3D engine...\n", .{});
    var engine = try Zig3D.init();
    defer engine.deinit();

    std.debug.print("Running Zig3D engine...\n", .{});
    try engine.run();

    std.debug.print("Zig3D engine finished successfully.\n", .{});
}
