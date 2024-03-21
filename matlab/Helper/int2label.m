function label = int2label(i)

switch i
    case 1
        label = 'x';
    case 2
        label = 'y';
    case 3
        label = 'z';
    case 4
        label = 'Rx';
    case 5
        label = 'Ry';
    case 6
        label = 'Rz';
    otherwise
        error('int2label: Unknown index!');
end

end

