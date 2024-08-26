const std = @import("std");

pub fn buildApp(b: *std.build.Builder) void {
    const builder = std.build(b);
    const target = builder.standardTargetOptions(.{});

    const exe_options = std.build.ExecutableOptions{
        .name = "zig3d",
    };
    const exe = builder.addExecutable(exe_options);
    exe.setTarget(target);

    exe.setBuildMode(builder.standardReleaseOptions());

    exe.addSourceFile("src/main.zig");
    exe.addSourceFile("src/math.zig");
    exe.addSourceFile("src/render.zig");
    exe.addSourceFile("src/zig3d.zig");

    // Link system libraries
    exe.linkSystemLibrary("glfw3"); // for Windows
    exe.linkSystemLibrary("GL"); // for Linux
    exe.linkSystemLibrary("GLU"); // for Linux
    exe.linkSystemLibrary("GLUT"); // for Linux

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(builder.getInstallStep());

    const run_step = builder.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const test_step = builder.step("test", "Run unit tests");
    const exe_tests = builder.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(builder.standardReleaseOptions());
    test_step.dependOn(&exe_tests.step);
}
