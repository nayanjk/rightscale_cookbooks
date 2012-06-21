

if ( node[:inmobi_wpsite][:language] == "global" )
    set_unless[:inmobi_wpsite][:wpmu_base] = "wpmu"
end
if ( node[:inmobi_wpsite][:language] == "japanese" )
    set_unless[:inmobi_wpsite][:wpmu_base] = "wpmu_jp"
end
    
