

if ( node[:inmobi_wpsite][:language] == "global" )
    set[:inmobi_wpsite][:wpmu_base] = "wpmu"
end
if ( node[:inmobi_wpsite][:language] == "japanese" )
    set[:inmobi_wpsite][:wpmu_base] = "wpmu_jp"
end
    
