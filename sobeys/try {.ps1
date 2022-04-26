try {
    Add-PnPListItem -list "xinet_images" -values @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;xinet_id=$file_id;}
    } catch {
        v = @{item_number=$item;Title=$n;fullpath=$fp;macpath=$mp;pcpath=$fn;xinet_id=$file_id;}
        v
    }
    start-sleep -Seconds 2