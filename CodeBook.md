## CodeBook

Other sample code book.

This sample is based on the PROPPR study of blood component ratios in transfusions in trauma patients. Warning: this is complicated.

Experimental design and background: Blood is given to trauma patients as blood components: red blood cells, plasma and platelets. This experiment was aimed at seeing if increasing the ratio of red blood cells over that in normal whole blood would lower mortality. There were two treatment groups, normal and increased red cells. Patients were screened at 12 participating hospitals. Randomization was done by per mutated random blocks, stratified by site.

Raw data: randomization assignment, date and time of admission to the hospital, type of injury, fluids given by EMT/paramedic before admission, hospital, time of blood product administration, lot number of blood product, time of hemostasis achieved, other fluids, pre-existing blood clotting diseases, pre-existing blood clotting inhibitors, date and time of discharge from ICU, date and time of ventilator start and stop, date and time of discharge from hospital and date and time of death (if death occurred within 30 days).

Processed data: Assignment was converted to treatment group (factor variable), type of injury was coded as a factor penetrating (1) or blunt (0), hospital was coded as a factor (1-12), EMT fluids were binned in 500ml bins, pre-existing clotting diseases were coded as a factor (each assigned a number), pre-existing clotting medications were coded as a factor. Other fluids were binned in 1L bins. Date of discharge from ICU was converted to ICU-free days (out of 30), Ventilator times were converted to ventilator-free days (out of 30), date of discharge was converted to hospital-free days (out of 30). Amount of blood products was summed in two groups, amount given until hemostasis and amount given from hemostasis until 24 hours, these were considered as numeric amounts, these were calculated from summing the blood product lot numbers, sorted by time of administration. Date of death was converted to 24-hour mortality (factor: yes=1 no=0) and 30-day mortality (factor: yes=1, no=0).

## sample codebook.


It's very similar to a Statistical Analysis Plan, actually.

Setup, there is a dogwalking business. It wants to analyze its work.

Raw data is: name of dog, address of owner, time walked, date walked, size of dog (small, medium, or large), health of dog (well or sick) on that date and time, comments, and pay.

The business wants to assign ID# to the dogs, and codewords to the address to make this data anonymous. There isn't anything to do to the comments--since free text is all over the place.

Codebook: The dog's name was transformed into an IDNumber (unique) (1-50), the address was transformed into a factor, OwnerName (levels Alice, Bob, Charlie, Deborah, Ernest and Fred), time and date walked were counted to make WalksPerWeek1, WalksPerWeek2, and WalksPerWeek3. Week1 begins at 00:01UTC on July1, 2014, Week2 begins at 00:01UTC on July8, 2014, Week3 begins at 00:01UTC on July15, 2014. Health was summarized as HealthWeek1, HealthWeek2, and HealthWeek3. It is a factor with two levels, Well and Sick. If the dog was sick at any walk during that week, dog was marked sick, else dog was marked well. Dog Size was converted into a factor: Large, Medium and Small are the levels. Comments are dropped. Pay is transformed into PayWeek1, PayWeek2, PayWeek3, which is a factor that has two levels (Yes, and No) for correct pay paid during that week.
