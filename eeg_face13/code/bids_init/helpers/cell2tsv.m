function [string] = cell2tsv(fname,cell_in,format_str)
% '%s %d %2.1f %s\n'
fid = fopen(fname,'w');

[nrows,ncols] = size(cell_in);
for row = 1:nrows
    if row==1
        for col=1:ncols;
            if col==1;
                if ncols==1;
                    head_format_str=['%s','\n'];
                else
                    head_format_str=['%s','\t'];
                end
            elseif col<ncols;
                head_format_str=[head_format_str,'%s','\t'];
            else
                head_format_str=[head_format_str,'%s','\n'];
            end
        end
        fprintf(fid,[head_format_str],cell_in{row,:});
    else
        fprintf(fid,[format_str],cell_in{row,:});
    end
end

end

