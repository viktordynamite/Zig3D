const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable("zig3d", "src/main.zig");
    exe.setTarget(target);

    exe.setBuildMode(b.standardReleaseOptions());

    exe.addSourceFile("src/math.zig");
    exe.addSourceFile("src/render.zig");
    exe.addSourceFile("src/zig3d.zig");

    // Add any dependencies
    // exe.addPackagePath("some_package", "path/to/package.zig");

    // Link system libraries
    // exe.linkSystemLibrary("c");
    // exe.linkSystemLibrary("opengl32"); // for Windows
    // exe.linkSystemLibrary("GL"); // for Linux

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const test_step = b.step("test", "Run unit tests");
    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(b.standardReleaseOptions());
    test_step.dependOn(&exe_tests.step);
}
