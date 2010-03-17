#!/usr/bin/env python
import ctypes, sys

libc = ctypes.CDLL('libc.dylib')
libc.realpath.restype = ctypes.c_char_p
libc.__error.restype = ctypes.POINTER(ctypes.c_int)
libc.strerror.restype = ctypes.c_char_p

def realpath(path):
  buffer = ctypes.create_string_buffer(1024) # PATH_MAX
  if libc.realpath(path, buffer):
    return buffer.value
  else:
    errno = libc.__error().contents.value
    raise OSError(errno, "%s: %s" % (libc.strerror(errno), buffer.value))

if __name__ == '__main__':
  print realpath(sys.argv[1])
