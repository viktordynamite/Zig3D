const std = @import("std");

pub const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn add(self: Vec3, other: Vec3) Vec3 {
        return Vec3{
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }

    pub fn subtract(self: Vec3, other: Vec3) Vec3 {
        return Vec3{
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
        };
    }

    pub fn multiply(self: Vec3, scalar: f32) Vec3 {
        return Vec3{
            .x = self.x * scalar,
            .y = self.y * scalar,
            .z = self.z * scalar,
        };
    }

    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }

    pub fn cross(self: Vec3, other: Vec3) Vec3 {
        return Vec3{
            .x = self.y * other.z - self.z * other.y,
            .y = self.z * other.x - self.x * other.z,
            .z = self.x * other.y - self.y * other.x,
        };
    }

    pub fn length(self: Vec3) f32 {
        return @sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
    }

    pub fn normalize(self: Vec3) Vec3 {
        const len = self.length();
        return Vec3{
            .x = self.x / len,
            .y = self.y / len,
            .z = self.z / len,
        };
    }
};

pub const Mat4 = struct {
    data: [4][4]f32,

    pub fn identity() Mat4 {
        return Mat4{
            .data = [_][4]f32{
                [_]f32{ 1, 0, 0, 0 },
                [_]f32{ 0, 1, 0, 0 },
                [_]f32{ 0, 0, 1, 0 },
                [_]f32{ 0, 0, 0, 1 },
            },
        };
    }

    pub fn multiply(self: Mat4, other: Mat4) Mat4 {
        var result = Mat4{};
        for (std.math.range(0, 4)) |i| {
            for (std.math.range(0, 4)) |j| {
                result.data[i][j] = 0;
                for (std.math.range(0, 4)) |k| {
                    result.data[i][j] += self.data[i][k] * other.data[k][j];
                }
            }
        }
        return result;
    }

    pub fn multiplyVec3(self: Mat4, vec: Vec3) Vec3 {
        return Vec3{
            .x = self.data[0][0] * vec.x + self.data[0][1] * vec.y + self.data[0][2] * vec.z + self.data[0][3],
            .y = self.data[1][0] * vec.x + self.data[1][1] * vec.y + self.data[1][2] * vec.z + self.data[1][3],
            .z = self.data[2][0] * vec.x + self.data[2][1] * vec.y + self.data[2][2] * vec.z + self.data[2][3],
        };
    }
};
