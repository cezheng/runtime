// Copyright 2020 The TensorFlow Runtime Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// RUN: tfrt_translate -mlir-to-bef %s | bef_executor | FileCheck %s --dump-input=fail

// CHECK-LABEL: --- Running 'BM_Conv2D_in_8x32x32x128_f_1x1x128'
func @BM_Conv2D_in_8x32x32x128_f_1x1x128() {
  %ch0 = hex.new.chain

  %zero = hex.constant.f32 0.0
  %one = hex.constant.f32 1.0

  // in: [8, 32, 32, 128].
  %in = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [8 : i64, 32 : i64, 32 : i64, 128 : i64] }
    : () -> !t.tensor
  %ch1 = dht.fill_tensor_with_constant.f32 %in, %ch0 1.0 : f32

  // kern: [1, 1, 128, 128].
  %kern = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [1 : i64, 1 : i64, 128 : i64, 128 : i64] }
    : () -> !t.tensor
  %ch2 = dht.fill_tensor_with_constant.f32 %kern, %ch1 1.0 : f32

  // bias: [128].
  %bias = "dht.create_uninitialized_tensor.f32.1"()
    { shape = [128 : i64] }
    : () -> !t.tensor
  %ch3 = dht.fill_tensor_with_constant.f32 %bias, %ch2 0.0 : f32

  // out: [8, 32, 32, 128].
  %out = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [8 : i64, 32 : i64, 32 : i64, 128 : i64] }
    : () -> !t.tensor

  tfrt_test.benchmark "BM_Conv2D_in_8x32x32x128_f_1x1x128"(
      %in   : !t.tensor,
      %kern : !t.tensor,
      %bias : !t.tensor,
      %out  : !t.tensor,
      %ch3  : !hex.chain
  )
  duration_secs = 5, max_count = 1000, num_warmup_runs = 10
  {
      %ch_out = "eigen.conv2d.bias.f32"(%in, %kern, %bias, %out, %ch3)
       { padding = "valid",  strides = [1 : i64, 1 : i64] }
       : (!t.tensor, !t.tensor, !t.tensor,
          !t.tensor, !hex.chain) -> !hex.chain

      hex.return %ch_out : !hex.chain
  }

  hex.return
}

// CHECK-LABEL: --- Running 'BM_Conv2D_in_32x28x28x96_f_1x1x128'
func @BM_Conv2D_in_32x28x28x96_f_1x1x128() {
  %ch0 = hex.new.chain

  %zero = hex.constant.f32 0.0
  %one = hex.constant.f32 1.0

  // in: [32, 28, 28, 96].
  %in = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [32 : i64, 28 : i64, 28 : i64, 96 : i64] }
    : () -> !t.tensor
  %ch1 = dht.fill_tensor_with_constant.f32 %in, %ch0 1.0 : f32

  // kern: [1, 1, 96, 128].
  %kern = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [1 : i64, 1 : i64, 96 : i64, 128 : i64] }
    : () -> !t.tensor
  %ch2 = dht.fill_tensor_with_constant.f32 %kern, %ch1 1.0 : f32

  // bias: [128].
  %bias = "dht.create_uninitialized_tensor.f32.1"()
    { shape = [128 : i64] }
    : () -> !t.tensor
  %ch3 = dht.fill_tensor_with_constant.f32 %bias, %ch2 0.0 : f32

  // out: [32, 28, 28, 128].
  %out = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [32 : i64, 28 : i64, 28 : i64, 128 : i64] }
    : () -> !t.tensor

  tfrt_test.benchmark "BM_Conv2D_in_32x28x28x96_f_1x1x128"(
      %in   : !t.tensor,
      %kern : !t.tensor,
      %bias : !t.tensor,
      %out  : !t.tensor,
      %ch3  : !hex.chain
  )
  duration_secs = 5, max_count = 1000, num_warmup_runs = 10
  {
      %ch_out = "eigen.conv2d.bias.f32"(%in, %kern, %bias, %out, %ch3)
       { padding = "valid",  strides = [1 : i64, 1 : i64] }
       : (!t.tensor, !t.tensor, !t.tensor,
          !t.tensor, !hex.chain) -> !hex.chain

      hex.return %ch_out : !hex.chain
  }

  hex.return
}

// CHECK-LABEL: --- Running 'BM_Conv2D_in_1x56x56x256_f_1x1x512'
func @BM_Conv2D_in_1x56x56x256_f_1x1x512() {
  %ch0 = hex.new.chain

  %zero = hex.constant.f32 0.0
  %one = hex.constant.f32 1.0

  // in: [1, 56, 56, 256].
  %in = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [1 : i64, 56 : i64, 56 : i64, 256 : i64] }
    : () -> !t.tensor
  %ch1 = dht.fill_tensor_with_constant.f32 %in, %ch0 1.0 : f32

  // kern: [1, 1, 256, 512].
  %kern = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [1 : i64, 1 : i64, 256 : i64, 512 : i64] }
    : () -> !t.tensor
  %ch2 = dht.fill_tensor_with_constant.f32 %kern, %ch1 1.0 : f32

  // bias: [512].
  %bias = "dht.create_uninitialized_tensor.f32.1"()
    { shape = [512 : i64] }
    : () -> !t.tensor
  %ch3 = dht.fill_tensor_with_constant.f32 %bias, %ch2 0.0 : f32

  // out: [1, 56, 56, 512].
  %out = "dht.create_uninitialized_tensor.f32.4"()
    { shape = [1 : i64, 56 : i64, 56 : i64, 512 : i64] }
    : () -> !t.tensor

  tfrt_test.benchmark "BM_Conv2D_in_1x56x56x256_f_1x1x512"(
      %in   : !t.tensor,
      %kern : !t.tensor,
      %bias : !t.tensor,
      %out  : !t.tensor,
      %ch3  : !hex.chain
  )
  duration_secs = 5, max_count = 1000, num_warmup_runs = 10
  {
      %ch_out = "eigen.conv2d.bias.f32"(%in, %kern, %bias, %out, %ch3)
       { padding = "valid",  strides = [1 : i64, 1 : i64] }
       : (!t.tensor, !t.tensor, !t.tensor,
          !t.tensor, !hex.chain) -> !hex.chain

      hex.return %ch_out : !hex.chain
  }

  hex.return
}
