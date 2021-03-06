package.path = package.path..";src/?.lua"
local mgl = require("MGL")
mgl.gen_mat(2); mgl.gen_vec(2)
mgl.gen_mat(3); mgl.gen_vec(3)
mgl.gen_mat(3,2); mgl.gen_mat(2,3)
mgl.gen_mat(4); mgl.gen_vec(4)

print(mgl.mat2({1,0,0,1}))
print(mgl.mat3(mgl.mat3(1)))
local m = mgl.mat4(1); print(m)
local m3x2 = mgl.mat3x2(1)
print("m3x2")
print(m3x2)
print("T m3x2")
print(mgl.transpose(m3x2))

assert(m == mgl.mat4(1))
assert(mgl.mat3(m) == mgl.mat3(1))
assert(m == mgl.mat4(mgl.mat3(1)))
assert(m ~= -m)
assert(m-m == mgl.mat4(0))
assert(2*m == (mgl.mat4(2)+mgl.mat4(2))/2)
assert(mgl.mat3(mgl.vec3(1,2,3), mgl.vec3(4,5,6), mgl.vec3(7,8,9)) == mgl.mat3({1,4,7,2,5,8,3,6,9}))
assert(m == mgl.transpose(m))
assert(m3x2*mgl.vec3(1) == mgl.vec2(1))
assert(m3x2 == mgl.transpose(mgl.transpose(m3x2)))
local m3x2T = m3x2*mgl.transpose(m3x2)
local Tm3x2 = mgl.transpose(m3x2)*m3x2
assert(m3x2T == mgl.transpose(m3x2T))
assert(Tm3x2 == mgl.transpose(Tm3x2))
assert(m*m == m)
assert(m*mgl.vec4(1) == mgl.vec4(1))
assert(mgl.determinant(mgl.mat2(1)) == 1)
assert(mgl.determinant(mgl.mat3(1)) == 1)
assert(mgl.determinant(mgl.mat4(1)) == 1)
assert(mgl.inverse(mgl.mat2(1))*mgl.mat2(1) == mgl.mat2(1))
assert(mgl.inverse(mgl.mat3(1))*mgl.mat3(1) == mgl.mat3(1))
assert(mgl.inverse(mgl.mat4(1))*mgl.mat4(1) == mgl.mat4(1))
assert(mgl.inverse(mgl.mat4(5))*mgl.mat4(5) == mgl.mat4(1))
assert(m:v(1) == mgl.vec4(1,0,0,0))
assert(m:v(2) == mgl.vec4(0,1,0,0))
assert(m:v(3) == mgl.vec4(0,0,1,0))
assert(m:v(4) == mgl.vec4(0,0,0,1))
m:v(1, mgl.vec4(-2))
m:v(4, mgl.vec4(2))
assert(m == mgl.mat4({
  -2,0,0,2,
  -2,1,0,2,
  -2,0,1,2,
  -2,0,0,2
}))
local m2 = mgl.mat4(0); mgl.copy(m2, m)
assert(m2 == m)
