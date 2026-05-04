using Base.BinaryPlatforms

# Can't use Preferences since we might be running this very early with a non-existing Manifest
# Fresh UUID for libigc_LTS_jll. Generated locally so augment_platform_block
# works on the very first build (Registrator will adopt this UUID at first
# registration). DO NOT reuse libigc_jll's UUID — it would make the two JLLs
# share the `debug` Preference.
libigc_LTS_jll_uuid = Base.UUID("f51f21b5-0bb5-45e9-bbe2-a331ec2cd4cc")
const preferences = Base.get_preferences(libigc_LTS_jll_uuid)
Base.record_compiletime_preference(libigc_LTS_jll_uuid, "debug")
const debug_preference = if haskey(preferences, "debug")
    if isa(preferences["debug"], Bool)
        preferences["debug"]
    elseif isa(preferences["debug"], String)
        parsed = tryparse(Bool, preferences["debug"])
        if parsed === nothing
            @error "Debug preference is not valid; expected a boolean, but got '$(preferences["debug"])'"
            nothing
        else
            parsed
        end
    else
        @error "Debug preference is not valid; expected a boolean, but got '$(preferences["debug"])'"
        nothing
    end
else
    nothing
end

function augment_platform!(platform::Platform)
    platform["debug"] = string(something(debug_preference, false))
    return platform
end