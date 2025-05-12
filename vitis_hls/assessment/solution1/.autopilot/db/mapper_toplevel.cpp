#include <systemc>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
extern "C" void toplevel(int*, int, volatile void *);
extern "C" void apatb_toplevel_hw(volatile void * __xlx_apatb_param_ram, volatile void * __xlx_apatb_param_code) {
  // Collect __xlx_ram__tmp_vec
  vector<sc_bv<32> >__xlx_ram__tmp_vec;
  for (int j = 0, e = 8518; j != e; ++j) {
    __xlx_ram__tmp_vec.push_back(((int*)__xlx_apatb_param_ram)[j]);
  }
  int __xlx_size_param_ram = 8518;
  int __xlx_offset_param_ram = 0;
  int __xlx_offset_byte_param_ram = 0*4;
  int* __xlx_ram__input_buffer= new int[__xlx_ram__tmp_vec.size()];
  for (int i = 0; i < __xlx_ram__tmp_vec.size(); ++i) {
    __xlx_ram__input_buffer[i] = __xlx_ram__tmp_vec[i].range(31, 0).to_uint64();
  }
  // DUT call
  toplevel(__xlx_ram__input_buffer, __xlx_offset_byte_param_ram, __xlx_apatb_param_code);
// print __xlx_apatb_param_ram
  sc_bv<32>*__xlx_ram_output_buffer = new sc_bv<32>[__xlx_size_param_ram];
  for (int i = 0; i < __xlx_size_param_ram; ++i) {
    __xlx_ram_output_buffer[i] = __xlx_ram__input_buffer[i+__xlx_offset_param_ram];
  }
  for (int i = 0; i < __xlx_size_param_ram; ++i) {
    ((int*)__xlx_apatb_param_ram)[i] = __xlx_ram_output_buffer[i].to_uint64();
  }
}
