# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule libigc_LTS_jll
using Base
using Base: UUID
using LazyArtifacts
Base.include(@__MODULE__, joinpath("..", ".pkg", "platform_augmentation.jl"))
import JLLWrappers

JLLWrappers.@generate_main_file_header("libigc_LTS")
JLLWrappers.@generate_main_file("libigc_LTS", Base.UUID("9a8258a1-e827-5686-bee9-144461246960"))
end  # module libigc_LTS_jll
