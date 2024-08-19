const std = @import("std");
const Zig3D = @import("zig3d.zig");

pub fn main() void {
    var engine = Zig3D.init();

    engine.run();

    engine.cleanup();
}
