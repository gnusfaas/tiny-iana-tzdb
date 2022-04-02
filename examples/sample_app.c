// -----------------------------------------------------------------------------
/// \file                  sample_app.c
/// \brief                 Sample application describing the TinyTZ lib API usage
/// \author                Sreejith.Naarakathil@gmail.com
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <time.h>

extern struct tm *tz_localtime(time_t const *);
extern void tz_set_time_zone_by_name(const char *tzname);
extern void tz_set_time_zone(int tz_id);

int main()
{
    // Read current unix timestamp value
    time_t now;
    struct tm*  tm;
    now = time(NULL);

    // Set time zone
    // tz_set_time_zone_by_name("America/New_York");
    tz_set_time_zone(2);
    printf("Current unix timestamp: %lld\n", now);

    // Calculate local time for the given time zone
    tm = tz_localtime(&now);
    printf("Local time: %s\n", asctime(tm));
    return 0;
}
