const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable("zig3d", "src/main.zig");
    exe.setTarget(target);

    exe.setBuildMode(b.standardReleaseOptions());

    exe.addSourceFile("src/math.zig");
    exe.addSourceFile("src/render.zig");
    exe.addSourceFile("src/zig3d.zig");

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
}
