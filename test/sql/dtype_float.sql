---
--- Test cases for floating point data types
---

---
--- float2
---
RESET pg_strom.enabled;
SELECT id,a,b
  INTO pg_temp.test_s01a
  FROM t_float2
 WHERE a > b AND sqrt(@b) < 100.0;
SELECT id,a,b,a+b v1, a-b v2, abs(a-b) v3, a*b v4, a/b v5
  INTO pg_temp.test_s02a
  FROM t_float2
 WHERE a < b AND @b BETWEEN 10.0 AND 10000.0;
SELECT id,a,b,(a+b)*(id%10) v1, (a-b)/(id%8 +1) v2
  INTO pg_temp.test_s03a
  FROM t_float2
 WHERE a = b OR a > @c;
SELECT id,a IS NULL v1, a+c v2, null::float2 v3, b-d v4
  INTO pg_temp.test_s04a
  FROM t_float2
 WHERE a < @c AND c < @d;
SELECT l.id,l.a, r.b, l.a + r.b v1, l.b - r.a v2
  INTO pg_temp.test_s05a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.b IS NOT NULL THEN @l.a < r.b
                             ELSE l.a BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.b, null::float2 v1, r.a, r.b IS NULL v2
  INTO pg_temp.test_s06a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.a BETWEEN r.b - 2000 AND r.b + 2000);

SET pg_strom.enabled = off;
SELECT id,a,b
  INTO pg_temp.test_s01b
  FROM t_float2
 WHERE a > b AND sqrt(@b) < 100.0;
SELECT id,a,b,a+b v1, a-b v2, abs(a-b) v3, a*b v4, a/b v5
  INTO pg_temp.test_s02b
  FROM t_float2
 WHERE a < b AND @b BETWEEN 10.0 AND 10000.0;
SELECT id,a,b,(a+b)*(id%10) v1, (a-b)/(id%8 +1) v2
  INTO pg_temp.test_s03b
  FROM t_float2
 WHERE a = b OR a > @c;
SELECT id,a IS NULL v1, a+c v2, null::float2 v3, b-d v4
  INTO pg_temp.test_s04b
  FROM t_float2
 WHERE a < @c AND c < @d;
SELECT l.id,l.a, r.b, l.a + r.b v1, l.b - r.a v2
  INTO pg_temp.test_s05b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.b IS NOT NULL THEN @l.a < r.b
                             ELSE l.a BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.b, null::float2 v1, r.a, r.b IS NULL v2
  INTO pg_temp.test_s06b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.a BETWEEN r.b - 2000 AND r.b + 2000);

(SELECT * FROM pg_temp.test_s01a l FULL OUTER JOIN pg_temp.test_s01b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.a  - r.a)   > 0.001
            OR abs(l.b  - r.b)   > 0.001);
(SELECT * FROM pg_temp.test_s02a l FULL OUTER JOIN pg_temp.test_s02b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.a  - r.a)   > 0.001
            OR abs(l.b  - r.b)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001
            OR abs(l.v3 - r.v3)  > 0.001
            OR abs(l.v4 - r.v4)  > 0.001
            OR abs(l.v5 - r.v5)  > 0.001);
(SELECT * FROM pg_temp.test_s03a l FULL OUTER JOIN pg_temp.test_s03b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.a  - r.a)   > 0.001
            OR abs(l.b  - r.b)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_s04a l FULL OUTER JOIN pg_temp.test_s04b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR l.v1 != r.v1
            OR abs(l.v2 - r.v2)  > 0.001
            OR l.v3 IS NOT NULL OR r.v3 IS NOT NULL
            OR abs(l.v4 - r.v4)  > 0.001);
(SELECT * FROM pg_temp.test_s05a l FULL OUTER JOIN pg_temp.test_s05b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.a  - r.a)   > 0.001
            OR abs(l.b  - r.b)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_s06a l FULL OUTER JOIN pg_temp.test_s06b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.a  - r.a)   > 0.001
            OR l.v1 IS NOT NULL OR r.v1 IS NOT NULL
            OR abs(l.b  - r.b)   > 0.001
            OR l.v2 != r.v2);

--
-- float4
--
RESET pg_strom.enabled;
SELECT id,c,d
  INTO pg_temp.test_i01a
  FROM t_float2
 WHERE c > d AND sqrt(@d) < 500.0;
SELECT id,c,d,c+d v1, c-d v2, abs(c-d) v3, c*d v4, c/d v5
  INTO pg_temp.test_i02a
  FROM t_float2
 WHERE c < d AND @d BETWEEN 10.0 AND 10000.0;
SELECT id,c,d,(c+d)*(id%10) v1, (c-d)/(id%8 +1) v2
  INTO pg_temp.test_i03a
  FROM t_float2
 WHERE c = d OR c > @d;
SELECT id,c IS NULL v1, c+e v2, null::float2 v3, d-f v4
  INTO pg_temp.test_i04a
  FROM t_float2
 WHERE c < (@e / 100.0) AND d < (@d / 100.0);
SELECT l.id,l.c, r.d, l.c + r.d v1, l.d - r.c v2
  INTO pg_temp.test_i05a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.d IS NOT NULL THEN @l.c < r.d
                             ELSE l.c BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.d, null::float2 v1, r.c, r.d IS NULL v2
  INTO pg_temp.test_i06a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.c BETWEEN r.d - 2000 AND r.d + 2000);

SET pg_strom.enabled = off;
SELECT id,c,d
  INTO pg_temp.test_i01b
  FROM t_float2
 WHERE c > d AND sqrt(@d) < 500.0;
SELECT id,c,d,c+d v1, c-d v2, abs(c-d) v3, c*d v4, c/d v5
  INTO pg_temp.test_i02b
  FROM t_float2
 WHERE c < d AND @d BETWEEN 10.0 AND 10000.0;
SELECT id,c,d,(c+d)*(id%10) v1, (c-d)/(id%8 +1) v2
  INTO pg_temp.test_i03b
  FROM t_float2
 WHERE c = d OR c > @d;
SELECT id,c IS NULL v1, c+e v2, null::float2 v3, d-f v4
  INTO pg_temp.test_i04b
  FROM t_float2
 WHERE c < (@e / 100.0) AND d < (@d / 100.0);
SELECT l.id,l.c, r.d, l.c + r.d v1, l.d - r.c v2
  INTO pg_temp.test_i05b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.d IS NOT NULL THEN @l.c < r.d
                             ELSE l.c BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.d, null::float2 v1, r.c, r.d IS NULL v2
  INTO pg_temp.test_i06b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.c BETWEEN r.d - 2000 AND r.d + 2000);

(SELECT * FROM pg_temp.test_i01a l FULL OUTER JOIN pg_temp.test_i01b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.c  - r.c)   > 0.001
            OR abs(l.d  - r.d)   > 0.001);
(SELECT * FROM pg_temp.test_i02a l FULL OUTER JOIN pg_temp.test_i02b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.c  - r.c)   > 0.001
            OR abs(l.d  - r.d)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001
            OR abs(l.v3 - r.v3)  > 0.001
            OR abs(l.v4 - r.v4)  > 0.001
            OR abs(l.v5 - r.v5)  > 0.001);
(SELECT * FROM pg_temp.test_i03a l FULL OUTER JOIN pg_temp.test_i03b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.c  - r.c)   > 0.001
            OR abs(l.d  - r.d)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_i04a l FULL OUTER JOIN pg_temp.test_i04b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR l.v1 != r.v1
            OR abs(l.v2 - r.v2)  > 0.001
            OR l.v3 IS NOT NULL OR r.v3 IS NOT NULL
            OR abs(l.v4 - r.v4)  > 0.001);
(SELECT * FROM pg_temp.test_i05a l FULL OUTER JOIN pg_temp.test_i05b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.c  - r.c)   > 0.001
            OR abs(l.d  - r.d)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_i06a l FULL OUTER JOIN pg_temp.test_i06b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.c  - r.c)   > 0.001
            OR l.v1 IS NOT NULL OR r.v1 IS NOT NULL
            OR abs(l.d  - r.d)   > 0.001
            OR l.v2 != r.v2);

---
--- float8
---
RESET pg_strom.enabled;
SELECT id,e,f
  INTO pg_temp.test_l01a
  FROM t_float2
 WHERE e > f AND sqrt(@f) < 500.0;
SELECT id,e,f,e+f v1, e-f v2, abs(e-f) v3, e*f v4, e/f v5
  INTO pg_temp.test_l02a
  FROM t_float2
 WHERE e < f AND @f BETWEEN 10.0 AND 10000.0;
SELECT id,e,f,(e+f)*(id%10) v1, (e-f)/(id%8 +1) v2
  INTO pg_temp.test_l03a
  FROM t_float2
 WHERE e = f OR e > @f;
SELECT id,e IS NULL v1, e+c v2, null::float2 v3, f-d v4
  INTO pg_temp.test_l04a
  FROM t_float2
 WHERE e < (@e / 100.0) AND f < (@f / 100.0);
SELECT l.id,l.e, r.f, l.e + r.f v1, l.f - r.e v2
  INTO pg_temp.test_l05a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.f IS NOT NULL THEN @l.e < r.f
                             ELSE l.e BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.f, null::float2 v1, r.e, r.f IS NULL v2
  INTO pg_temp.test_l06a
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.e BETWEEN r.f - 2000 AND r.f + 2000);

SET pg_strom.enabled = off;
SELECT id,e,f
  INTO pg_temp.test_l01b
  FROM t_float2
 WHERE e > f AND sqrt(@f) < 500.0;
SELECT id,e,f,e+f v1, e-f v2, abs(e-f) v3, e*f v4, e/f v5
  INTO pg_temp.test_l02b
  FROM t_float2
 WHERE e < f AND @f BETWEEN 10.0 AND 10000.0;
SELECT id,e,f,(e+f)*(id%10) v1, (e-f)/(id%8 +1) v2
  INTO pg_temp.test_l03b
  FROM t_float2
 WHERE e = f OR e > @f;
SELECT id,e IS NULL v1, e+c v2, null::float2 v3, f-d v4
  INTO pg_temp.test_l04b
  FROM t_float2
 WHERE e < (@e / 100.0) AND f < (@f / 100.0);
SELECT l.id,l.e, r.f, l.e + r.f v1, l.f - r.e v2
  INTO pg_temp.test_l05b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id AND (CASE WHEN r.f IS NOT NULL THEN @l.e < r.f
                             ELSE l.e BETWEEN 2000.0 AND 6000.0
                        END);
SELECT l.id,l.f, null::float2 v1, r.e, r.f IS NULL v2
  INTO pg_temp.test_l06b
  FROM t_float1 l, t_float2 r
 WHERE l.id = r.id
   AND (l.e BETWEEN r.f - 2000 AND r.f + 2000);

(SELECT * FROM pg_temp.test_l01a l FULL OUTER JOIN pg_temp.test_l01b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.e  - r.e)   > 0.001
            OR abs(l.f  - r.f)   > 0.001);
(SELECT * FROM pg_temp.test_l02a l FULL OUTER JOIN pg_temp.test_l02b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.e  - r.e)   > 0.001
            OR abs(l.f  - r.f)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001
            OR abs(l.v3 - r.v3)  > 0.001
            OR abs(l.v4 - r.v4)  > 0.001
            OR abs(l.v5 - r.v5)  > 0.001);
(SELECT * FROM pg_temp.test_l03a l FULL OUTER JOIN pg_temp.test_l03b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.e  - r.e)   > 0.001
            OR abs(l.f  - r.f)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_l04a l FULL OUTER JOIN pg_temp.test_l04b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR l.v1 != r.v1
            OR abs(l.v2 - r.v2)  > 0.001
            OR l.v3 IS NOT NULL OR r.v3 IS NOT NULL
            OR abs(l.v4 - r.v4)  > 0.001);
(SELECT * FROM pg_temp.test_l05a l FULL OUTER JOIN pg_temp.test_l05b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.e  - r.e)   > 0.001
            OR abs(l.f  - r.f)   > 0.001
            OR abs(l.v1 - r.v1)  > 0.001
            OR abs(l.v2 - r.v2)  > 0.001);
(SELECT * FROM pg_temp.test_l06a l FULL OUTER JOIN pg_temp.test_l06b r ON l.id = r.id
         WHERE l.id IS NULL
            OR r.id IS NULL
            OR abs(l.e  - r.e)   > 0.001
            OR l.v1 IS NOT NULL OR r.v1 IS NOT NULL
            OR abs(l.f  - r.f)   > 0.001
            OR l.v2 != r.v2);
